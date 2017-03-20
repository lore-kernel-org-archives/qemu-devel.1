Received: from eggs.gnu.org ([2001:4830:134:3::10]:33323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpxkM-0005BU-KB
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpxkL-0000h1-SM
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:53:18 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:36123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpxkL-0000fE-JZ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:53:17 -0400
Received: by mail-wm0-x22e.google.com with SMTP id n11so64113201wma.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 06:53:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490014476-25672-1-git-send-email-peter.maydell@linaro.org>
References: <1490014476-25672-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 13:52:55 +0000
Message-ID: <CAFEAcA8h_-+k6BL3CuVQ9fFMYt1mgfmMu8r79nGO0YoG13aFiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/4] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 20 March 2017 at 12:54, Peter Maydell <peter.maydell@linaro.org> wrote:
> Small target-arm queue for 2.9: just the patches
> which fix bugs in our MRS/MSR decoding for M profile,
> including a fix for a regression introduced in commit
> 58117c9bb429cd.
>
> thanks
> -- PMM
>
> The following changes since commit 00e7c07b06d004cf54b19724f82afde8a7a37f37:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170320' into staging (2017-03-20 10:51:30 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170320
>
> for you to fetch changes up to b28b3377d7e9ba35611d454d5a63ef50cab1f8c5:
>
>   arm: Fix APSR writes via M profile MSR (2017-03-20 12:41:44 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * fix MSR/MRS decoding for M profile CPUs
>

Applied, thanks.

-- PMM
