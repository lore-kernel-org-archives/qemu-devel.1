Received: from eggs.gnu.org ([2001:4830:134:3::10]:59939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewuhU-0007Si-05
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewuhT-0004pk-3R
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:07:35 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:43097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewuhS-0004pV-V0
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 15:07:35 -0400
Received: by mail-ot0-x22b.google.com with SMTP id m22-v6so11407778otf.10
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 12:07:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180315171828.5214-1-kwolf@redhat.com>
References: <20180315171828.5214-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Mar 2018 19:07:14 +0000
Message-ID: <CAFEAcA-FmgwihxDLPq6xO2NLhHLrtfcbrEv7WX17huymrCNZgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/44] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 15 March 2018 at 17:18, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 56e8698ffa8aba9f762f980bc21b5340b006f24b:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-speedup-130318-1' into staging (2018-03-15 14:48:09 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to d3137181e5e1e5e6b651b58484fc8f705a48ee36:
>
>   iscsi: fix iSER compilation (2018-03-15 17:58:26 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>

I get merge conflicts trying to apply this; please fix and resend:

Auto-merging tests/qemu-iotests/group
CONFLICT (content): Merge conflict in tests/qemu-iotests/group
Auto-merging tests/qemu-iotests/209.out
CONFLICT (add/add): Merge conflict in tests/qemu-iotests/209.out
Auto-merging tests/qemu-iotests/209
CONFLICT (add/add): Merge conflict in tests/qemu-iotests/209

thanks
-- PMM
