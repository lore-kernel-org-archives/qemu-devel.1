Received: from eggs.gnu.org ([209.51.188.92]:43860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxEcG-0003YN-2J
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:28:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gxEcF-0002Ck-9a
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:28:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41331)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gxEcF-0001HE-1n
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:28:03 -0500
References: <1548638112-31101-1-git-send-email-lizhijian@cn.fujitsu.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <f4c6777f-e577-fef9-e952-a6a9b8e2c37c@redhat.com>
Date: Fri, 22 Feb 2019 12:27:26 -0500
MIME-Version: 1.0
In-Reply-To: <1548638112-31101-1-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Acceptance tests: use linux-3.6 and
 set vm memory to 4GiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>



On 1/27/19 8:15 PM, Li Zhijian wrote:
> QEMU have already supported to load up to 4G initrd if the sepcified me=
mory is
> enough and XLF_CAN_BE_LOADED_ABOVE_4G is set by guest kernel
>=20
> linux-3.6 kernel shipped by Fedora-18 cannot support xldflags so that i=
t
> cannot support loading more than 2GiB initrd
>=20
> CC: Wainer dos Santos Moschetta <wainersm@redhat.com>
> CC: Caio Carrara <ccarrara@redhat.com>
> CC: Cleber Rosa <crosa@redhat.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>=20


Reviewed-by: Cleber Rosa <crosa@redhat.com>
