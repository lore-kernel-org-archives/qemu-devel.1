Received: from eggs.gnu.org ([2001:4830:134:3::10]:47471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehciE-0000D6-UU
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehciE-00082m-0f
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:53:11 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:39077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ehciD-00082b-R5
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:53:09 -0500
Received: by mail-oi0-x22f.google.com with SMTP id j188so14820295oib.6
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 06:53:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517511182-9944-1-git-send-email-minyard@acm.org>
References: <1517511182-9944-1-git-send-email-minyard@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2018 14:52:48 +0000
Message-ID: <CAFEAcA9oyt069w4BQG-v=wL_mieu_6pffrN66Lgt576n4OpX4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Small IPMI fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 February 2018 at 18:52,  <minyard@acm.org> wrote:
> The following changes since commit 6521130b0a7f699fdb82446d57df5627bfa7ed3c:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2018-01-26-2' into staging (2018-01-30 15:20:01 +0000)
>
> are available in the git repository at:
>
>   https://github.com/cminyard/qemu.git tags/for-release-20180201
>
> for you to fetch changes up to 20b233641d76cc1812064304798ffeb530dc112d:
>
>   ipmi: Allow BMC device properties to be set (2018-01-30 15:52:53 -0600)
>
> ----------------------------------------------------------------
> Lots of litte miscellaneous fixes for the IPMI code, plus
> add me as the IPMI maintainer.
>
> ----------------------------------------------------------------

Applied, thanks.

PS: it would be useful if you could arrange to get your gpg key
signed by more people, as and when you have the opportunity for that.

-- PMM
