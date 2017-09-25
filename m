Received: from eggs.gnu.org ([2001:4830:134:3::10]:59079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwbjY-0000LU-BC
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwbjX-0007bC-Ca
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:20:12 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:48302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dwbjX-0007b1-5b
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:20:11 -0400
Received: by mail-wm0-x235.google.com with SMTP id m127so1928637wmm.3
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 15:20:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170924180848.19168-1-samuel.thibault@ens-lyon.org>
References: <20170924180848.19168-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Sep 2017 23:19:49 +0100
Message-ID: <CAFEAcA-E7M3thRHLZ8ji8NhoDA22FCDZkxHiztRzpROV4fHudg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 24 September 2017 at 19:08, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
> warning: redirection vers https://people.debian.org/~sthibault/qemu.git/
> The following changes since commit 460b6c8e581aa06b86f59eebd9e52edfe7adf417:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-09-23 12:55:40 +0100)
>
> are available in the git repository at:
>
>   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 13146a83951e045c810c37c5c11c2a016ebc0663:
>
>   slirp: Add a special case for the NULL socket (2017-09-24 20:04:09 +0200)
>
> ----------------------------------------------------------------
> slirp updates
>
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (1):
>       slirp: Add explanation for hostfwd parsing failure
>
> Kevin Cernekee (2):
>       slirp: Fix intermittent send queue hangs on a socket
>       slirp: Add a special case for the NULL socket

Applied, thanks.

-- PMM
