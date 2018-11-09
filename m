Received: from eggs.gnu.org ([2001:4830:134:3::10]:35916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gLEJR-0004j3-5g
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 16:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gLEJO-0007mF-64
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 16:27:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gLEJK-0007kW-Bn
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 16:27:26 -0500
Date: Fri, 9 Nov 2018 19:27:14 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181109212714.GE12503@habkost.net>
References: <20181109150710.31085-1-crosa@redhat.com>
	<20181109150710.31085-3-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109150710.31085-3-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] check-venv: use recorded Python version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

On Fri, Nov 09, 2018 at 10:07:08AM -0500, Cleber Rosa wrote:
> The current approach works fine, but it runs Python on every make
> command (even if it's not related to the venv usage).
> 
> This is just an optimization, and not a change of behavior.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
