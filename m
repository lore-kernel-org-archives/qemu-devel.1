Received: from eggs.gnu.org ([209.51.188.92]:35900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h3Vsj-0000Ba-6i
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h3Vsi-0002c8-GR
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 21:07:01 -0400
Date: Mon, 11 Mar 2019 21:06:49 -0400
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190312010649.ggn3qjxkv7x6ftvx@localhost.localdomain>
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-16-crosa@redhat.com>
	<79cdbc7f-0e8e-d9be-fb15-afd2e94d382c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <79cdbc7f-0e8e-d9be-fb15-afd2e94d382c@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 15/20] Boot Linux Console Test: add a
 test for mips64el + malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Sat, Mar 02, 2019 at 10:39:47PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 2/21/19 1:57 AM, Cleber Rosa wrote:
> > +import os
>=20
> One import is enough :P
>

Oh my... thanks for spotting this.

- Cleber.
