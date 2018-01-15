Received: from eggs.gnu.org ([2001:4830:134:3::10]:38821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eb2dV-0003HW-Pa
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eb2dR-0000uZ-Ns
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:09:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eb2dR-0000uL-Hz
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:09:01 -0500
References: <20180114020412.26160-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <250b835d-8f13-4dfe-1720-e889046dd9a3@redhat.com>
Date: Mon, 15 Jan 2018 12:08:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180114020412.26160-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] add helpers to be more explicit
 when using QOM abstract parent hooks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 14/01/2018 03:04, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> Learning how to implement QOM devices I found the pattern changing pare=
nt hooks
> when the parent is abstract not trivial to understand.
>=20
> This series add few helpers to have this pattern more explicit.
>=20
> Those functions deserve some comments, but before spending more time I'=
d like
> to get some feedbacks if this might be useful or not.
> If so, I can split the 3rd patch in many patches for each subsystem mai=
ntainers.
>=20
> This can also be use for the CPUClass->reset() method, dunno if useful =
but
> maybe to be consistent.

Queued, thanks.

Paolo
