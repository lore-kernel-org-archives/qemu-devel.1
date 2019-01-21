Received: from eggs.gnu.org ([209.51.188.92]:58792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glgF2-0002JO-BC
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1glgF1-00082C-NP
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 15:32:20 -0500
Date: Mon, 21 Jan 2019 18:32:03 -0200
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <20190121203202.GM17671@localhost.localdomain>
References: <20190117185628.21862-1-crosa@redhat.com>
	<20190117185628.21862-15-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117185628.21862-15-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/18] Boot Linux Console Test: add a test
 for ppc64 + pseries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

On Thu, Jan 17, 2019 at 01:56:24PM -0500, Cleber Rosa wrote:
> Just like the previous tests, boots a Linux kernel on a ppc64 target
> using the pseries machine.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Caio Carrara <ccarrara@redhat.com>

> ---
>  .travis.yml                            |  2 +-
>  scripts/qemu.py                        |  1 -
>  tests/acceptance/boot_linux_console.py | 19 +++++++++++++++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
{...}
> 

-- 
Caio Carrara
Software Engineer, Virt Team - Red Hat
ccarrara@redhat.com
