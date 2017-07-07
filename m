Received: from eggs.gnu.org ([2001:4830:134:3::10]:41465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dTGkv-0006B8-P2
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dTGkr-00008y-R9
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:04:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dTGkr-00008X-Kb
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 20:04:17 -0400
Date: Fri, 7 Jul 2017 08:04:13 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170707000413.GH5149@lemon.lan>
References: <20170629010300.2848-1-f4bug@amsat.org>
	<149938495160.27.9558172081317902741@7a482c8a7db2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149938495160.27.9558172081317902741@7a482c8a7db2>
Subject: Re: [Qemu-devel] [RFC PATCH 0/8] removal of tci (tcg interpreter)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: f4bug@amsat.org, peter.maydell@linaro.org, sw@weilnetz.de, cota@braap.org, pbonzini@redhat.com, alex.bennee@linaro.org, rth@twiddle.net

On Thu, 07/06 16:49, no-reply@patchew.org wrote:
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> fatal: Cannot update paths and switch to branch 'test' at the same time.
> Did you intend to checkout 'origin/patchew/20170629010300.2848-1-f4bug@amsat.org' which can not be resolved as commit?
> Traceback (most recent call last):
>   File "/home/fam/bin/patchew", line 440, in test_one
>     git_clone_repo(clone, r["repo"], r["head"], logf)
>   File "/home/fam/bin/patchew", line 53, in git_clone_repo
>     cwd=clone)
>   File "/usr/lib64/python3.5/subprocess.py", line 271, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['git', 'checkout', 'origin/patchew/20170629010300.2848-1-f4bug@amsat.org', '-b', 'test']' returned non-zero exit status 128
> 

Ignore this please, patchew is recovering from a bad state.
