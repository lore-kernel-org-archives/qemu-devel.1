Received: from eggs.gnu.org ([2001:4830:134:3::10]:56912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f9LVD-0007yF-6O
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f9LVA-0004Oq-17
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:10:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54950 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f9LV9-0004Od-TT
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 22:10:15 -0400
Date: Fri, 20 Apr 2018 10:10:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180420021012.GC17690@lemon.usersys.redhat.com>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/43] fix building of tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, cota@braap.org, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On Thu, 04/19 14:58, Alex Benn=E9e wrote:
> Hi,
>=20
> This is the second revision of my attempt to revive the tests/tcg
> directory. You can find the first iteration here:
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg01361.html

Thanks for taking over! I cannot review all the patches, but for the Dock=
er
part:

Acked-by: Fam Zheng <famz@redhat.com>
