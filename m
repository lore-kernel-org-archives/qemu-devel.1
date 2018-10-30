Received: from eggs.gnu.org ([2001:4830:134:3::10]:54615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHQUm-0004xG-FK
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHQUe-0008UX-CE
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:39:28 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:33342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHQUV-0008II-TB
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:39:18 -0400
Received: by mail-ot1-x333.google.com with SMTP id q1so993478otk.0
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 02:39:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181029141834.8794-1-kraxel@redhat.com>
References: <20181029141834.8794-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 09:38:49 +0000
Message-ID: <CAFEAcA-yEuH1=PpB3sZPNGcwdNFi_DyVBzyRdChxJRFdmnuA5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Ui 20181029 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 29 October 2018 at 14:18, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 285278ca785f5fa9a570927e1c0958a2ca2b2150:
>
>   Merge remote-tracking branch 'remotes/famz/tags/testing-pull-request' into staging (2018-10-27 19:55:08 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20181029-pull-request
>
> for you to fetch changes up to 9c956e646178fee8c14ce7dfae5a9d7cb901876c:
>
>   spice: prepare for upcoming spice-server change (2018-10-29 14:38:17 +0100)
>
> ----------------------------------------------------------------
> ui: sdl+spice tweaks.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   spice: prepare for upcoming spice-server change
>
> Sebastian Krzyszkowiak (1):
>   SDL: set a hint to not bypass the window compositor
>
>  ui/sdl2.c          |  3 +++
>  ui/spice-display.c | 26 ++++++++++++++++++++++----
>  2 files changed, 25 insertions(+), 4 deletions(-)

Applied, thanks.

-- PMM
