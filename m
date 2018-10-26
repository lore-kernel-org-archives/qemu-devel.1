Received: from eggs.gnu.org ([2001:4830:134:3::10]:42709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gG3r6-0006sX-Ii
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gG3r1-0001HL-K8
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:16:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gG3r1-0001HC-CR
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:16:51 -0400
Date: Fri, 26 Oct 2018 12:16:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181026151636.GF3902@habkost.net>
References: <20181018153134.8493-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018153134.8493-1-crosa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/3] Bootstrap Python venv and
 acceptance/functional tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>

On Thu, Oct 18, 2018 at 11:31:31AM -0400, Cleber Rosa wrote:
> TL;DR
> =====
> 
> Allow acceptance tests to be run with `make check-acceptance`.

Queued on python-next, thanks!

-- 
Eduardo
