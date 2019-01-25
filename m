Received: from eggs.gnu.org ([209.51.188.92]:50150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gn1us-0006oq-TV
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gn1kz-0000FA-UQ
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 08:42:54 -0500
Date: Fri, 25 Jan 2019 11:42:45 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190125134245.GD4136@habkost.net>
References: <1548410602-16008-1-git-send-email-pbonzini@redhat.com>
	<fa3b6ce0-0fc4-7ee8-653b-5c0aecfa6d30@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <fa3b6ce0-0fc4-7ee8-653b-5c0aecfa6d30@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] decodetree: re.fullmatch was added in 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Fri, Jan 25, 2019 at 01:45:00PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing maintainers :P
>=20
> $ ./scripts/get_maintainer.pl -f scripts/decodetree.py
> Eduardo Habkost <ehabkost@redhat.com> (odd fixer:Python scripts)
> Cleber Rosa <crosa@redhat.com> (odd fixer:Python scripts)
>=20
> On 1/25/19 11:03 AM, Paolo Bonzini wrote:
> > Python 3 versions earlier than 3.4 do not have it, use the
> > same workaround that is in place for 3.0.
> >=20
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Queued, thanks!

--=20
Eduardo
