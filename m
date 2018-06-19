Received: from eggs.gnu.org ([2001:4830:134:3::10]:50140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVFyr-0000RI-MK
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVFyq-0001HR-NE
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:43:29 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:44490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVFyq-0001HL-HV
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:43:28 -0400
Received: by mail-ot0-x242.google.com with SMTP id w13-v6so22359353ote.11
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 05:43:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180618092132.7253-1-kraxel@redhat.com>
References: <20180618092132.7253-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Jun 2018 13:43:07 +0100
Message-ID: <CAFEAcA9enjKn8muv1fcYW+ncmpWBcqDkUQQdbZNcB8fX5fZgBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Usb 20180618 patches
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

On 18 June 2018 at 10:21, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799fa2:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20180615a' into staging (2018-06-15 18:13:35 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20180618-pull-request
>
> for you to fetch changes up to 0d1e8d6f4a2ced75f673edfe4d6cb78f3b361144:
>
>   Revert "bus: do not unref the added child bus on realize" (2018-06-18 09:15:51 +0200)
>
> ----------------------------------------------------------------
> usb: revert ccid / qom patches.
>
> ----------------------------------------------------------------
>

Applied, thanks.

-- PMM
