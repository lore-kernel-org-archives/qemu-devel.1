Received: from eggs.gnu.org ([2001:4830:134:3::10]:49329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gK0kY-0004l4-Qa
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gK0kX-0001n7-Pw
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:46:30 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gK0kX-0001mW-JW
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 07:46:29 -0500
Received: by mail-oi1-x242.google.com with SMTP id u130-v6so10558857oie.7
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 04:46:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541421653.git.artem.k.pisarenko@gmail.com>
	<ae16b7e9df62708e0556a13a1efa8aa2628c1c56.1541421653.git.artem.k.pisarenko@gmail.com>
	<CAJ+F1C+B4swAvyEYvvaeBX=bjtDoPgGPOHq46md7WgSmWGuuhg@mail.gmail.com>
In-Reply-To: <CAJ+F1C+B4swAvyEYvvaeBX=bjtDoPgGPOHq46md7WgSmWGuuhg@mail.gmail.com>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Tue, 6 Nov 2018 18:46:17 +0600
Message-ID: <CANzW0mtF3BcVpnwuc6z=0wcbLR4j6paLVtTFfY0V0rmcT3viZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tests/test-char: add muxed chardev
 testing for open/close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

> this is unnecessary change, I can drop on commit

Oops, didn't noticed your message before sent v3.
