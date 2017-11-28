Received: from eggs.gnu.org ([2001:4830:134:3::10]:60724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eJaqh-0006xm-4M
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 03:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eJaqc-0003WO-Hv
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 03:02:35 -0500
Received: from mail-he1eur01hn0217.outbound.protection.outlook.com
	([104.47.0.217]:59585
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eJaqc-0003VV-5B
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 03:02:30 -0500
Date: Tue, 28 Nov 2017 11:02:13 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20171128080213.GA12787@rkaganb.sw.ru>
References: <20171127130518.26703-1-rkagan@virtuozzo.com>
	<20171127130518.26703-3-rkagan@virtuozzo.com>
	<A9252286-892F-40F4-9BE5-A9F92CC75DF9@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <A9252286-892F-40F4-9BE5-A9F92CC75DF9@skyportsystems.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vmgenid: use UUID property type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Denis V. Lunev" <den@openvz.org>, minyard@acm.org, "Daniel P. Berrange" <berrange@redhat.com>

On Mon, Nov 27, 2017 at 08:38:41AM -0800, Ben Warren wrote:
> It looks like you dropped Marc-Andr=E9 and my Reviewed-by lines.  Please =
put them back.

Oops.  I thought that the amount of changes in the first patch was too
big to keep the R-b; however, the second patch was basically the same so
I should have put the R-b and save you extra work re-reviewing it.
Sorry about that; hope the maintainer who will pick the patches will
take care of R-b (unless I get more feedback that will make me respin the
set).

Roman.
