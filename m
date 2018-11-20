Received: from eggs.gnu.org ([2001:4830:134:3::10]:38988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP83J-0000MU-Bh
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP83I-00030e-Hp
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:35:01 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP83I-00030B-DI
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:35:00 -0500
Received: by mail-oi1-x242.google.com with SMTP id b141so1794562oii.12
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 07:35:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181115192446.17187-10-minyard@acm.org>
References: <20181115192446.17187-1-minyard@acm.org>
	<20181115192446.17187-10-minyard@acm.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 15:34:39 +0000
Message-ID: <CAFEAcA9puY3914dPM5zLq=rign6igw5ZbK5iWhr1rDHVq3OamQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 09/12] i2c: Add normal type name and
 cast to smbus_eeprom.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Corey Minyard <cminyard@mvista.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 15 November 2018 at 19:24,  <minyard@acm.org> wrote:
> From: Corey Minyard <cminyard@mvista.com>
>
> Create a type name and a cast macro and use those through the
> code.
>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  hw/i2c/smbus_eeprom.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
