Received: from eggs.gnu.org ([2001:4830:134:3::10]:59495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHsMc-0004fM-97
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHsMX-00074o-DH
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:48:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHsMX-000744-75
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:48:05 -0400
References: <20170602130518.22943-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <88a5d9d3-1827-2b31-b81a-f755da583f52@redhat.com>
Date: Mon, 5 Jun 2017 15:48:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170602130518.22943-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/4] some gdbstub fixes for debug and
 vcont
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, doug16k@gmail.com, imbrenda@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org



On 02/06/2017 15:05, Alex Benn=C3=A9e wrote:
> Hi,
>=20
> This is v3 and hopefully the final version the gdbstub fixes. There is
> one minor change to patch two where I pulled forward the move of
> cpu_gdb_index into gdbstub.c from the third patch.
>=20
> Otherwise it is basically a re-base and a whole host of Reviewed-by
> tags.
>=20
> So the final question is who's tree is going to accept these patches?
>=20
> The gdbstub is currently marked as "Odd fixes" via qemu-devel. If no
> one wants to take it via their tree and Peter is happy I can roll the
> pullreq directly.

With pleasure (but I reported an issue on patch 3).

Thanks,

Paolo
