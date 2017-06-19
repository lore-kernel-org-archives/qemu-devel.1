Received: from eggs.gnu.org ([2001:4830:134:3::10]:38695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMsCN-00049e-D5
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 04:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMsCJ-000749-Fh
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 04:38:15 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:44208 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMsCJ-00072L-46
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 04:38:11 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727924970.28532.9346819516051209538.stgit@frigg.lan>
	<20170615221911.GB26408@flamenco> <20170615232507.GA15332@flamenco>
	<87r2yhe5os.fsf@frigg.lan> <87a855b8n8.fsf@frigg.lan>
	<87y3sp9d36.fsf@frigg.lan> <20170619041028.GB10709@flamenco>
Date: Mon, 19 Jun 2017 11:37:54 +0300
In-Reply-To: <20170619041028.GB10709@flamenco> (Emilio G. Cota's message of
	"Mon, 19 Jun 2017 00:10:28 -0400")
Message-ID: <87injs9xul.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 3/6] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Emilio G Cota writes:

> On Mon, Jun 19, 2017 at 00:54:05 +0300, Llu=C3=ADs Vilanova wrote:
>> Aha, just checked your proposed patches more closely and it totally make=
s sense
>> to keep "is_jmp" to simplify the diffs, so I'll go for that one.

> Also I think it's important to break down the changes to each
> architecture into separate patches, otherwise the diff becomes
> impossible to read. I went quite a long way with arm/translate.c
> on Friday.

Yes, I'm onto it, thanks :)

Lluis
