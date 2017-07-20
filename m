Received: from eggs.gnu.org ([2001:4830:134:3::10]:53631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYEh9-0006pE-AR
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYEh8-00084v-Hy
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:52:59 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYEh8-00083v-AI
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:52:58 -0400
Received: by mail-wr0-x22d.google.com with SMTP id y43so73138815wrd.3
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 09:52:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170720075526.7383-1-kraxel@redhat.com>
References: <20170720075526.7383-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 17:52:36 +0100
Message-ID: <CAFEAcA-7eCrg=bLXUESZ32fK=Q=L=R3RNzQtCnrHf-3JyMh3zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Ui 20170720 patches
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

On 20 July 2017 at 08:55, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit d4e59218ab80e86015753782fb5378767a51ccd0:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-07-18-2' into staging (2017-07-19 20:45:37 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20170720-pull-request
>
> for you to fetch changes up to b02cf99b9d998b3ec23dae8a4a8210e222b4294b:
>
>   keymaps: fr-ca: more fixups (2017-07-20 09:25:44 +0200)
>
> ----------------------------------------------------------------
> ui fixes (vnc docs, keymaps) for 2.10
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   keymaps: fr-ca: more fixups
>
> Markus Armbruster (1):
>   vnc: Clarify documentation of QMP command change
>
>  pc-bios/keymaps/fr-ca | 10 +++++++++-
>  qapi-schema.json      |  3 +--
>  2 files changed, 10 insertions(+), 3 deletions(-)

Applied, thanks.

-- PMM
