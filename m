Received: from eggs.gnu.org ([2001:4830:134:3::10]:60263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYBhJ-0001X9-3Q
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYBhI-0005mW-58
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:40:57 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:32858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYBhH-0005mH-TF
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:40:56 -0400
Received: by mail-wr0-x233.google.com with SMTP id v105so40819359wrb.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 06:40:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170720080022.8104-1-kraxel@redhat.com>
References: <20170720080022.8104-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 14:40:33 +0100
Message-ID: <CAFEAcA87TjhWRzjfwjGV5ZFd4V2ShZa5kp2gZCRht4rk=bg7hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Misc 20170720 patches
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

On 20 July 2017 at 09:00, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit d4e59218ab80e86015753782fb5378767a51ccd0:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-07-18-2' into staging (2017-07-19 20:45:37 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/misc-20170720-pull-request
>
> for you to fetch changes up to a62e20f6f84d747e55891a0d8aadd0737297571e:
>
>   add editorconfig (2017-07-20 09:56:56 +0200)
>
> ----------------------------------------------------------------
> git orderfile and editorconfig for 2.10
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (2):
>   add scripts/git.orderfile
>   add editorconfig
>
>  .editorconfig         | 15 +++++++++++++++
>  scripts/git.orderfile | 29 +++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>  create mode 100644 .editorconfig
>  create mode 100644 scripts/git.orderfile

Applied, thanks.

-- PMM
