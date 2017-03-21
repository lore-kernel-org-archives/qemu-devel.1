Received: from eggs.gnu.org ([2001:4830:134:3::10]:36993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqLyM-0007K9-C8
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 11:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqLyL-00072d-Hi
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 11:45:22 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cqLyL-00072H-Aw
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 11:45:21 -0400
Received: by mail-wm0-x235.google.com with SMTP id t189so15609173wmt.1
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 08:45:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490105580-5008-1-git-send-email-groug@kaod.org>
References: <1490105580-5008-1-git-send-email-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Mar 2017 15:44:59 +0000
Message-ID: <CAFEAcA-k1+aZ7M8TpRtAjUugmEyWyV9qcMRmBcVD-JtL3=uMzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] 9pfs fixes 2017-03-21 for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 March 2017 at 14:12, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 940a8ce075e3408742a4edcabfd6c2a15e2539eb:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-03-20 16:34:26 +0000)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 262169abe74b4c2d8b299b7499904cfc3c1902ea:
>
>   9pfs: proxy: assert if unmarshal fails (2017-03-21 09:12:47 +0100)
>
> ----------------------------------------------------------------
> This pull request fixes a potential QEMU hang in 9pfs and two issues
> reported by Coverity.
>
> ----------------------------------------------------------------
> Greg Kurz (2):
>       9pfs: don't try to flush self and avoid QEMU hang on reset
>       9pfs: proxy: assert if unmarshal fails

Applied, thanks.

-- PMM
