Received: from eggs.gnu.org ([2001:4830:134:3::10]:39606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dsa7S-00052p-Hd
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dsa7O-0004ZS-3V
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:48:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dsa7N-0004Yw-T5
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:48:10 -0400
Date: Thu, 14 Sep 2017 16:48:04 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170914194804.GC25664@localhost.localdomain>
References: <20170830225225.27925-1-f4bug@amsat.org>
	<20170830225225.27925-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170830225225.27925-4-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/7] mips: split cpu_mips_realize_env()
 out of cpu_mips_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Igor Mammedov <imammedo@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Marcel Apfelbaum <marcel@redhat.com>, James Hogan <james.hogan@imgtec.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 07:52:21PM -0300, Philippe Mathieu-Daud=E9 wrote:
> so it can be used in mips_cpu_realizefn() in the next commit
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Tested-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: James Hogan <james.hogan@imgtec.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
