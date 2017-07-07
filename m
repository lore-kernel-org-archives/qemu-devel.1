Received: from eggs.gnu.org ([2001:4830:134:3::10]:36653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTQWe-0005ST-KB
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTQWb-00038D-IL
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:30:16 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:55765 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTQWb-00037s-4p
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:30:13 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865534644.17063.5754453204442221401.stgit@frigg.lan>
	<20170630011154.GM13979@flamenco>
Date: Fri, 07 Jul 2017 12:29:57 +0200
In-Reply-To: <20170630011154.GM13979@flamenco> (Emilio G. Cota's message of
	"Thu, 29 Jun 2017 21:11:54 -0400")
Message-ID: <8737a8fska.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 13/29] target/i386: [tcg] Port to
 generic translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Emilio G Cota writes:

> On Wed, Jun 28, 2017 at 16:09:06 +0300, Llu=C3=ADs Vilanova wrote:
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---

> Reviewed-by: Emilio G. Cota <cota@braap.org>
> Tested-by: Emilio G. Cota <cota@braap.org>

> BTW have you tested icount mode?

Yes. Regular, -singlestep and -icount 1.

Thanks,
  Lluis
