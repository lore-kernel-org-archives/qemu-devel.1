Received: from eggs.gnu.org ([2001:4830:134:3::10]:54401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dPrrP-00074x-PH
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dPrrP-0001Py-0D
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 10:52:59 -0400
Date: Tue, 27 Jun 2017 22:52:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170627145248.GH14166@lemon.lan>
References: <20170626123510.20134-1-berrange@redhat.com>
	<149857461892.29731.17688834718600195927@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149857461892.29731.17688834718600195927@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH v6 0/5] Improve I/O tests coverage of LUKS
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On Tue, 06/27 07:43, no-reply@patchew.org wrote:
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Traceback (most recent call last):
>   File "./patchew-cli", line 430, in test_one
>     git_clone_repo(clone, r["repo"], r["head"], logf)
>   File "./patchew-cli", line 48, in git_clone_repo
>     stdout=logf, stderr=logf)
>   File "/usr/lib64/python3.5/subprocess.py", line 266, in check_call
>     retcode = call(*popenargs, **kwargs)
>   File "/usr/lib64/python3.5/subprocess.py", line 249, in call
>     return p.wait(timeout=timeout)
>   File "/usr/lib64/python3.5/subprocess.py", line 1389, in wait
>     (pid, sts) = self._try_wait(0)
>   File "/usr/lib64/python3.5/subprocess.py", line 1339, in _try_wait
>     (pid, sts) = os.waitpid(self.pid, wait_flags)
> KeyboardInterrupt

My mistake, sorry for the noise.

Fam
