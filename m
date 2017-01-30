Received: from eggs.gnu.org ([2001:4830:134:3::10]:32996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cYBqs-0000G3-2V
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:18:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cYBqn-0000gQ-0J
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:18:34 -0500
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80]:39038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1cYBqm-0000cH-Pi
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:18:28 -0500
References: <69936381-a99e-adc4-5de0-0f9bdf85323b@weilnetz.de>
	<f2110c0b-45b5-e2d0-b95d-a12d402cad1d@de.ibm.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <7381411f-a5f1-6f11-9fe4-bba7119e04b3@weilnetz.de>
Date: Mon, 30 Jan 2017 14:18:27 +0100
MIME-Version: 1.0
In-Reply-To: <f2110c0b-45b5-e2d0-b95d-a12d402cad1d@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: Fix broken user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

Am 30.01.2017 um 11:01 schrieb Christian Borntraeger:
> I have for whatever reasons problems with this patch. Looks like you
> pasted
> it into thunderbird or something like that and the whitespaces look mangled,
> e.g. look at the indentation of static vs {.

The original e-mail was not delivered by my mail server.
Therefore I had sent it as "new" with Thunderbird, which
wrapped some lines.

I'm sorry for that and have sent a v2 which should be fine.

Stefan
