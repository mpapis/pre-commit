module PreCommit
  class WhiteSpaceCheck
    def self.call(_)
      errors = `git diff-index --check --cached HEAD -- 2>&1`
      return if $?.success?

      # Initial commit: diff against the empty tree object
      if errors =~ /fatal: bad revision 'HEAD'/
        errors = `git diff-index --check --cached 4b825dc642cb6eb9a060e54bf8d69288fbee4904 -- 2>&1`
        return if $?.success?
      end

      errors
    end
  end
end
