Received: from eggs.gnu.org ([2001:4830:134:3::10]:60254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dG4Z7-00039n-FE
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dG4Z6-0006Mh-Sp
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:25:37 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dG4Z6-0006Lh-Jl
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:25:36 -0400
Received: by mail-wm0-x235.google.com with SMTP id 7so120843503wmo.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 07:25:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJSP0QVzoN=2rv_HUNf0oR_FQg=5xJ9UQbLqq0rj8OuYb8ZByw@mail.gmail.com>
References: <CAJSP0QVzoN=2rv_HUNf0oR_FQg=5xJ9UQbLqq0rj8OuYb8ZByw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 May 2017 15:25:13 +0100
Message-ID: <CAFEAcA-AjqsFnk8O3vVO-zhWwowfgZuJi0PWgezPO6K-Ye2cqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC] QEMU 2.10 release schedule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>

On 30 May 2017 at 11:11, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> Here is a first stab at the next release schedule:
>
> Beginning of development phase: 2017-04-20
> Soft feature freeze: 2017-07-18
> -rc0: 2017-07-25
> -rc1: 2017-08-01
> -rc2: 2017-08-08
> -rc3: 2017-08-15
> -rc4: 2017-08-22

Are we going with the same definitions of soft/hard freeze
as last time around?

(I thought last release was a complete mess in terms of
getting code in in an orderly manner for the freeze,
personally...)

thanks
-- PMM
