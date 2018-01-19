Received: from eggs.gnu.org ([2001:4830:134:3::10]:45533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecaw1-0000ve-KY
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecavy-0002xb-JN
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:58:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecavy-0002wf-Em
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:58:34 -0500
Date: Fri, 19 Jan 2018 15:58:28 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180119175828.GJ15832@localhost.localdomain>
References: <20180116131555.14242-1-f4bug@amsat.org>
	<20180116131555.14242-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180116131555.14242-2-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/11] smbus: add a NULL check for
 SMBusDeviceClass::init callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org

On Tue, Jan 16, 2018 at 10:15:45AM -0300, Philippe Mathieu-Daud=E9 wrote:
> ensure SMBusDeviceClass::init is set before calling it
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
