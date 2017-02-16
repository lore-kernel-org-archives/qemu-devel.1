Received: from eggs.gnu.org ([2001:4830:134:3::10]:35462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ceMEW-0002lW-D1
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ceMET-0001PW-BT
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:36:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ceMET-0001PH-5Q
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:36:25 -0500
Date: Thu, 16 Feb 2017 21:36:21 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170216133621.GA10337@lemon.lan>
References: <20170216123456.28621-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170216123456.28621-1-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/4] Docker cross-compile targets and
 user build support
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

On Thu, 02/16 12:34, Alex Benn=E9e wrote:
> Hi Fam,
>=20
> Here is the latest iteration of the docker changes incorporating your
> suggestions:
>=20
>   - -u behaves safely if user already added
>   - cross containers specify QEMU_CONFIGURE_OPTS
>   - merged docker and build automation in MAINTAINERS

Thanks for iterating.  I suggested a few minor changes, after which I thi=
nk it's
time to merge!

Fam
