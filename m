Received: from eggs.gnu.org ([2001:4830:134:3::10]:40158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dTGhS-0003KA-HI
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dTGhR-0006YY-Na
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:00:46 -0400
Date: Fri, 7 Jul 2017 08:00:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170707000034.GB1529@lemon.lan>
References: <20170627154120.20346-1-stefanha@redhat.com>
	<149938491950.27.16467577801751003579@7a482c8a7db2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149938491950.27.16467577801751003579@7a482c8a7db2>
Subject: Re: [Qemu-devel] [PATCH v2] docs: add qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, el13635@mail.ntua.gr

On Thu, 07/06 16:48, no-reply@patchew.org wrote:
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> fatal: unable to access 'https://github.com/patchew-project/qemu/': Could not resolve host: github.com
> error: Could not fetch 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Traceback (most recent call last):
>   File "/home/fam/bin/patchew", line 440, in test_one
>     git_clone_repo(clone, r["repo"], r["head"], logf)
>   File "/home/fam/bin/patchew", line 48, in git_clone_repo
>     stdout=logf, stderr=logf)
>   File "/usr/lib64/python3.5/subprocess.py", line 271, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['git', 'remote', 'add', '-f', '--mirror=fetch', '3c8cf5a9c21ff8782164d1def7f44bd888713384', 'https://github.com/patchew-project/qemu']' returned non-zero exit status 1

Ignore this please, patchew is recovering from a bad state.

Fam
