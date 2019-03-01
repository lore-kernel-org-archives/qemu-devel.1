Received: from eggs.gnu.org ([209.51.188.92]:47216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gzfEA-0002s9-8Y
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:17:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gzfE9-00011f-Jo
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:17:14 -0500
Date: Fri, 1 Mar 2019 11:16:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190301111659.520ba3f5.cohuck@redhat.com>
In-Reply-To: <20190221005753.27955-2-crosa@redhat.com>
References: <20190221005753.27955-1-crosa@redhat.com>
	<20190221005753.27955-2-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/20] scripts/qemu.py: log QEMU launch
 command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>

On Wed, 20 Feb 2019 19:57:34 -0500
Cleber Rosa <crosa@redhat.com> wrote:

> Even when the launch of QEMU succeeds, it's useful to have the command
> line recorded.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  scripts/qemu.py | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
