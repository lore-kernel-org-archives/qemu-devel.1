Received: from eggs.gnu.org ([2001:4830:134:3::10]:39419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpzTn-0001jG-W0
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpzTm-0001lB-V4
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:44:20 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpzTm-0001kt-OX
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:44:18 -0400
Received: by mail-wr0-x236.google.com with SMTP id g10so95195277wrg.2
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 08:44:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
References: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 15:43:57 +0000
Message-ID: <CAFEAcA9ytEzzJk3NZ2MU_ePo61fvxZEjAqpiJQnxnNEURPjFVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for v2.9 00/10] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 March 2017 at 13:00, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
> The following changes since commit bedf13ecab38bcd479e9db6994ebc3b2c5c7a3ae:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-fixes-20170320-1' into staging (2017-03-20 10:05:45 +0000)
>
> are available in the git repository at:
>
>   git://github.com/yongbok/upstream-qemu.git tags/mips-20170320
>
> for you to fetch changes up to 659f42d8c30bad9bf677652fc9d3f0ada63fd6e0:
>
>   MAINTAINERS: update for MIPS devices (2017-03-20 11:20:46 +0000)
>
> ----------------------------------------------------------------
> MIPS patches 2017-03-20
>
> Changes:
> * Fix clang warnings
> * Fix delay slot detection in gen_msa_branch()
> * Fix rc4030 interval timer
> * Fix rc4030 to tranlate memory accesses only when they occur
> * Fix 4c4030 a mixed declarations and code warning
> * Update MAINTAINERS file
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
