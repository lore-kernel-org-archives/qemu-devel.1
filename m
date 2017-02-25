Received: from eggs.gnu.org ([2001:4830:134:3::10]:49308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chgTE-0007F7-AB
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 12:49:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chgTD-0004MW-Ej
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 12:49:24 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chgTD-0004MO-8I
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 12:49:23 -0500
Received: by mail-wm0-x231.google.com with SMTP id v77so35043613wmv.1
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 09:49:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170224063205.2537-1-famz@redhat.com>
References: <20170224063205.2537-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Feb 2017 17:49:01 +0000
Message-ID: <CAFEAcA8sMWzHfmfsC_kVbt6CcYqxeGaun2HaoCP=+ce_A5LtwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/5] Docker testing and shippable patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 24 February 2017 at 06:32, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 10f25e4844cb9b3f02fb032f88051dd5b65b4206:
>
>   Merge remote-tracking branch 'remotes/yongbok/tags/mips-20170222' into staging (2017-02-23 09:59:40 +0000)
>
> are available in the git repository at:
>
>   git://github.com/famz/qemu.git tags/for-upstream
>
> for you to fetch changes up to a8f159d45bcb78c00ea160bfc2b94512e4ed9910:
>
>   docker: Install python2 explicitly in docker image (2017-02-24 14:18:11 +0800)
>
> ----------------------------------------------------------------
>
> Hi Peter,
>
> These are testing and build automation patches:
>
> - Shippable.com powered CI config
> - Docker cross build
> - Fixes and MAINTAINERS tweaks.

Applied, thanks.

-- PMM
