Received: from eggs.gnu.org ([2001:4830:134:3::10]:57588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXUXw-0004yZ-2Q
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXUXv-0001lI-Di
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:36:24 -0400
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-28-f4bug@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <1be4e013-0c63-a76c-70b5-b7fc54df2706@redhat.com>
Date: Tue, 18 Jul 2017 11:36:13 -0400
MIME-Version: 1.0
In-Reply-To: <20170718061005.29518-28-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 27/29] tests/hbitmap: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Fam Zheng <famz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org



On 07/18/2017 02:10 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osde=
p.cocci
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: John Snow <jsnow@redhat.com>
