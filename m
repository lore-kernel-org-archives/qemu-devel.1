Received: from eggs.gnu.org ([2001:4830:134:3::10]:36341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clCFL-000492-Rk
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:21:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clCFI-0001fc-LE
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:21:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1clCFI-0001f3-GD
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 05:21:32 -0500
Date: Tue, 7 Mar 2017 18:21:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170307102129.GH29283@lemon.lan>
References: <20170306205520.32311-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170306205520.32311-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] tests/docker: support proxy / corporate
 firewall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Mon, 03/06 17:55, Philippe Mathieu-Daud=E9 wrote:
> if ftp_proxy/http_proxy/https_proxy standard environment variables avai=
lable,
> pass them to the docker daemon to build images.
> this is required when building behind corporate proxy/firewall, but als=
o help
> when using local cache server (ie: apt/yum).
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Queued for 2.10, thanks.

Fam
