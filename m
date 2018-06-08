Received: from eggs.gnu.org ([2001:4830:134:3::10]:35975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fRIyX-00069N-FK
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fRIyW-0004o7-Q2
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:06:49 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:51361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fRIyW-0004nH-JE
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:06:48 -0400
Received: by mail-wm0-x230.google.com with SMTP id r15-v6so3915391wmc.1
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 08:06:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJSP0QURm0Y6FBByzY=kgf7JmDDyt5PLkkxk+ODi21uQKUGq5A@mail.gmail.com>
References: <CAJSP0QURm0Y6FBByzY=kgf7JmDDyt5PLkkxk+ODi21uQKUGq5A@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 8 Jun 2018 16:06:46 +0100
Message-ID: <CAJSP0QWe+yBNoXUuKcNw=zAOGC-fGZqzC5CcubFWsVhraYsiKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Cortex M0 emulation tasks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>
Cc: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Mon, May 28, 2018 at 3:26 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> Tasks:
>
> D3.3 Instruction Support
> D3.5.1 Alignment support

Julia and I have discussed these two tasks and she will work on them.

I will implement an undefined instruction test case that verifies that
all undefined instructions do indeed raise the expected exception.

Stefan
