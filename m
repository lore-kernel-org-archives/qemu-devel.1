Received: from eggs.gnu.org ([2001:4830:134:3::10]:42193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dTGmk-0007sN-4t
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dTGmj-0001Od-1s
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:06:14 -0400
Date: Fri, 7 Jul 2017 08:06:05 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170707000605.GM5149@lemon.lan>
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<149938491367.27.7931935785971048243@7a482c8a7db2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149938491367.27.7931935785971048243@7a482c8a7db2>
Subject: Re: [Qemu-devel] [RFC PATCH 00/11] Block layer thread-safety,
 next part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

On Thu, 07/06 16:48, no-reply@patchew.org wrote:
> fatal: Cannot update paths and switch to branch 'test' at the same time.
> Did you intend to checkout 'origin/patchew/20170706163828.24082-1-pbonzini@redhat.com' which can not be resolved as commit?
> Traceback (most recent call last):
>   File "/home/fam/bin/patchew", line 440, in test_one
>     git_clone_repo(clone, r["repo"], r["head"], logf)
>   File "/home/fam/bin/patchew", line 53, in git_clone_repo
>     cwd=clone)
>   File "/usr/lib64/python3.5/subprocess.py", line 271, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['git', 'checkout', 'origin/patchew/20170706163828.24082-1-pbonzini@redhat.com', '-b', 'test']' returned non-zero exit status 128

Ignore this please, patchew is recovering from a bad state.
