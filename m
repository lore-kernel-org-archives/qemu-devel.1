Received: from eggs.gnu.org ([2001:4830:134:3::10]:39960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVHTX-0007hg-6D
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVHTW-0005hj-8u
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:19:15 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:45399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVHTW-0005hJ-3W
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:19:14 -0400
Received: by mail-oi0-x233.google.com with SMTP id 188-v6so18251273oid.12
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 07:19:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180618101841.21609-1-kraxel@redhat.com>
References: <20180618101841.21609-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Jun 2018 15:18:52 +0100
Message-ID: <CAFEAcA9V+=8vF08=mf0bGFNxFUW4M3poc5pVH1+Nq1T72Khmxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Input 20180618 patches
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

On 18 June 2018 at 11:18, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799fa2:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180615a' into staging (2018-06-15 18:13:35 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/input-20180618-pull-request
>
> for you to fetch changes up to b55a06df4f03f21e8a32e9d067a8a5782ac3ce0d:
>
>   ps2: check PS2Queue wptr pointer in post_load routine (2018-06-18 12:06:45 +0200)
>
> ----------------------------------------------------------------
> input: ps2 post_load fix.
>
> ----------------------------------------------------------------
>
> liujunjie (1):
>   ps2: check PS2Queue wptr pointer in post_load routine
>

Applied, thanks.

-- PMM
