Received: from eggs.gnu.org ([2001:4830:134:3::10]:46493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXTYS-0002Nb-42
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXTYQ-0003xR-VE
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:37:24 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:35317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXTYQ-0003xB-Pq
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:37:22 -0400
Received: by mail-ot0-x234.google.com with SMTP id a6-v6so1007577otf.2
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 08:37:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180625131253.11218-1-kraxel@redhat.com>
References: <20180625131253.11218-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 16:37:01 +0100
Message-ID: <CAFEAcA8JSLxQ08tCfZ4Apdhg1JLmWGmeC4eLVFKXGM4H9=V_Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] Audio 20180625 patches
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

On 25 June 2018 at 14:12, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 46012db666990ff2eed1d3dc199ab8006439a93b:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180619' into staging (2018-06-20 09:51:30 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20180625-pull-request
>
> for you to fetch changes up to 441b345313f1355fb2464f3b37a07a1ded85b61a:
>
>   audio: Convert use of atoi to qemu_strtoi (2018-06-25 14:03:30 +0200)
>
> ----------------------------------------------------------------
> audio: new timer code for hda codec, fix audio_get_conf_int
>
Applied, thanks.

-- PMM
