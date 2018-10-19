Received: from eggs.gnu.org ([2001:4830:134:3::10]:45779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gDNHT-0007ok-Ca
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gDNHS-0001Fa-Dg
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:25:03 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1gDNHS-0001CK-3J
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:25:02 -0400
Received: by mail-oi1-x242.google.com with SMTP id v69-v6so25926457oif.1
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 22:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539846575.git.artem.k.pisarenko@gmail.com>
	<b29d3807-6ae3-94c6-aab3-af872a075eb7@redhat.com>
In-Reply-To: <b29d3807-6ae3-94c6-aab3-af872a075eb7@redhat.com>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Fri, 19 Oct 2018 11:24:49 +0600
Message-ID: <CANzW0mupRkJgOQnem13fOkfSZ_DeSd-M9fBTs84RHbTnboxVvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Fix and improve core RTC function
 and documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

> As a start of future refactoring, would you mind moving all this code to
> hw/timer/rtc.c or rtc.c?  It was somewaht generic before, but now it's
> very tied to -rtc.

Yes, sure.
