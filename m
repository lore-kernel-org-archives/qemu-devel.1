Received: from eggs.gnu.org ([2001:4830:134:3::10]:57721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cinp1-0001Xt-Mx
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cinp0-0000aw-Ma
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:52:31 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cinp0-0000ap-GB
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:52:30 -0500
Received: by mail-wm0-x236.google.com with SMTP id v77so93592246wmv.1
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 11:52:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488275176-16613-1-git-send-email-groug@kaod.org>
References: <1488275176-16613-1-git-send-email-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 19:52:08 +0000
Message-ID: <CAFEAcA_ynCzG3p6iYTZE7g1yx5E1_4hbr6U=P3OfiL6uJML0-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/3] 9p patches 2018-02-27 for 2.9 soft
 freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

On 28 February 2017 at 09:46, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 9b9fbe8a4e9eec9072ee2697a6af59144442785f:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170227-1' into staging (2017-02-27 19:19:46 +0000)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to a2a7862ca9ab1689f094c319ec92ecbd6fd1b46d:
>
>   throttle: factor out duplicate code (2017-02-28 10:31:46 +0100)
>
> ----------------------------------------------------------------
> This pull request brings:
> - a fix to a minor bug reported by Coverity
> - throttling support in the local backend (command line only)
>
> This replaces the previous pull request I had sent on 02/27:
> - authorship for throttle support was fixed
> - fixes for CVE-2016-9602 will be sent in a separate pull request as
>   suggested by Michael Tokarev
>
> Thanks.
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
