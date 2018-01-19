Received: from eggs.gnu.org ([2001:4830:134:3::10]:56618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecYXK-0000V6-Du
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecYXJ-0000hR-If
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:24:58 -0500
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:38205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecYXJ-0000h8-EG
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:24:57 -0500
Received: by mail-oi0-x234.google.com with SMTP id m65so1347132oig.5
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 07:24:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMxuvazG-y3XpE09oBRCJtB1OcNSbOP4heyGXYFHpLMbFj7VnA@mail.gmail.com>
References: <20180117144756.31049-1-marcandre.lureau@redhat.com>
	<595f00e6-d5ad-b7c6-29be-7c6e135f9d12@redhat.com>
	<CAFEAcA_M7FazuMDpne5Fr=hQUmfp75BHqttYOWV+HJ9zinW6mA@mail.gmail.com>
	<CAMxuvazG-y3XpE09oBRCJtB1OcNSbOP4heyGXYFHpLMbFj7VnA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2018 15:24:36 +0000
Message-ID: <CAFEAcA-Z4PbC+Ze7uGriu-V+qJcLMVjEjeYJsrMbgemnHAu6bQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Dump patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andre Lureau <mlureau@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 19 January 2018 at 14:35, Marc-Andre Lureau <mlureau@redhat.com> wrote:
> I have not found how to translate a python 'buffer' to a bytes string
> in 2.6.

A local python expert suggests that "bytes(buffer)" should work.

thanks
-- PMM
