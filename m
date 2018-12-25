Received: from eggs.gnu.org ([208.118.235.92]:58985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gbkBw-0001QO-HZ
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 05:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gbkBr-0001l2-Ic
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 05:44:04 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gbkBr-0001jp-DG
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 05:43:59 -0500
Received: by mail-wr1-x432.google.com with SMTP id q18so13400897wrx.9
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 02:43:59 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d134f875-ba27-67f9-5d7e-493896945b68@amsat.org>
Date: Tue, 25 Dec 2018 11:43:55 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/52] Audio 5.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Hi Zoltán,

On 12/23/18 9:51 PM, Kővágó, Zoltán wrote:
> I've updated my audio patchset to the current git master. Other than that not
> much happened since my last update [1], fixed a few small problems that I
> noticed while rebasing my patches.

For a such series with refactors and typedefs changes, I recommend you
to use/setup the scripts/git.orderfile script: Headers are showed first,
then the sources, which makes review easier (no need to constantly scroll).
No need to resend, but if you have to respin, this will be appreciated.

Regards,

Phil.
