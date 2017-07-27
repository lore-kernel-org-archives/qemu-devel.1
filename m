Received: from eggs.gnu.org ([2001:4830:134:3::10]:52270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dahtq-0000d1-Jg
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:28:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dahtp-00037n-Om
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:28:18 -0400
Date: Thu, 27 Jul 2017 14:28:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170727122802.GD4767@localhost.localdomain>
References: <20170725153645.26412-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170725153645.26412-1-stefanha@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] qemu-iotests: add a "how to" to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, eblake@redhat.com, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

Am 25.07.2017 um 17:36 hat Stefan Hajnoczi geschrieben:
> There is not much getting started documentation for qemu-iotests.  This
> patch explains how to create a new test and covers the overall testing
> approach.
>=20
> Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Do you want to address the late v1 comments from Peter (needs to be run
from build tree) and Jeff (mention common.qemu next to Python tests)?

Kevin
