Received: from eggs.gnu.org ([2001:4830:134:3::10]:49545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSUHU-0006rr-QL
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSUHR-00082q-LO
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:23:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSUHR-00082b-FM
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:23:13 -0400
Date: Mon, 11 Jun 2018 18:23:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180611212311.GC7451@localhost.localdomain>
References: <20180606165527.17365-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180606165527.17365-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] i386: improve output from "-cpu help"
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jun 06, 2018 at 05:55:24PM +0100, Daniel P. Berrang=E9 wrote:
> This short series is a set of improvements to the "-cpu help" output fo=
r
> the x86 emulator. The patches describe what's change in each step, but
> it is best visualized by looking at before/after state.
[...]

Queue on x86-next, thanks!

--=20
Eduardo
