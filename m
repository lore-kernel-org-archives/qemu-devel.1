Received: from eggs.gnu.org ([2001:4830:134:3::10]:53360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clEq9-0005Pd-9b
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 08:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clEq8-0006sl-3y
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 08:07:45 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:34587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1clEq7-0006sZ-Tk
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 08:07:44 -0500
Received: by mail-wm0-x22f.google.com with SMTP id 196so24219271wmm.1
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 05:07:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488839828-4231-1-git-send-email-jcmvbkbc@gmail.com>
References: <1488839828-4231-1-git-send-email-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Mar 2017 13:07:22 +0000
Message-ID: <CAFEAcA83sCcGQj-TFg2TaQ5JzSHFyspGonkcF_LAeCZQwpVc3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] xtensa updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 March 2017 at 22:37, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull the following batch of updates for target/xtensa.
>
> The following changes since commit 10f25e4844cb9b3f02fb032f88051dd5b65b4206:
>
>   Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170222' into staging (2017-02-23 09:59:40 +0000)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20170306-xtensa
>
> for you to fetch changes up to cb3825b9afdb1800cef1be9c9a732c803d8bb29e:
>
>   target/xtensa: add two missing headers to core import script (2017-02-23 10:50:56 -0800)
>
> ----------------------------------------------------------------
> target/xtensa updates:
>
> - instantiate local memories in xtensa sim machine;
> - add two missing include files to xtensa core importing script.
>
> ----------------------------------------------------------------
> Max Filippov (2):
>       target/xtensa: sim: instantiate local memories
>       target/xtensa: add two missing headers to core import script
>

Applied, thanks.

-- PMM
