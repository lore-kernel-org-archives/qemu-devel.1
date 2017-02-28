Received: from eggs.gnu.org ([2001:4830:134:3::10]:58525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cigP3-00048B-5X
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 06:57:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cigOy-0002xC-CY
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 06:57:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cigOy-0002x8-7c
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 06:57:08 -0500
Date: Tue, 28 Feb 2017 19:57:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170228115702.GB29328@lemon.lan>
References: <20170227143028.16428-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170227143028.16428-1-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/2] s390x cross Docker target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Mon, 02/27 14:30, Alex Benn=E9e wrote:
> Hi,
>=20
> A build failure on s390 was reported so to investigate I put together
> a cross-compile environment to debug it. As it turned out the report
> was a false positive but the cross target might still be useful for
> people who don't have big iron handy ;-)

Looks good:

Reviewed-by: Fam Zheng <famz@redhat.com>
