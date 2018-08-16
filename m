Received: from eggs.gnu.org ([2001:4830:134:3::10]:60764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqLM5-000435-4I
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqLM4-0008Tq-E7
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:42:37 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:38785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqLM4-0008Tg-7H
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:42:36 -0400
Received: by mail-oi0-x243.google.com with SMTP id v8-v6so9164028oie.5
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:42:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNfQGtC-jcn=f8kDFZt_SPrOhMGgx11=2m4C6BF1gHQVA@mail.gmail.com>
References: <20180816145554.9814-1-stefanha@redhat.com>
	<CAKmqyKNfQGtC-jcn=f8kDFZt_SPrOhMGgx11=2m4C6BF1gHQVA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 17:42:15 +0100
Message-ID: <CAFEAcA8v2oYzxVwmWeWHmju4vGyha+vTkfbSZNcQYWWGAnvAZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] docs/generic-loader: mention U-Boot and
 Intel HEX executable formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>

On 16 August 2018 at 16:54, Alistair Francis <alistair23@gmail.com> wrote:
> On Thu, Aug 16, 2018 at 7:55 AM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>> The generic loader device supports the U-Boot and Intel HEX executable
>> formats in addition to the document raw and ELF formats.  Reword the
>> documentation to include these formats and explain how various options
>> depend on the executable format.
>>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Applied to target-arm.next, thanks.

-- PMM
