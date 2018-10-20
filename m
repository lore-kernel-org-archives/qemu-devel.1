Received: from eggs.gnu.org ([2001:4830:134:3::10]:55146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDfXS-0002WN-EW
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 20:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDfXR-0007H8-Ep
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 20:54:46 -0400
References: <20181019191523.12157-1-mreitz@redhat.com>
	<20181019191523.12157-8-mreitz@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <d122cf73-c7df-27a5-5734-91b4220c7794@redhat.com>
Date: Fri, 19 Oct 2018 20:54:38 -0400
MIME-Version: 1.0
In-Reply-To: <20181019191523.12157-8-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 7/9] iotests: 'new' module replacement
 in 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>



On 10/19/18 3:15 PM, Max Reitz wrote:
> iotest 169 uses the 'new' module to add methods to a class.  This module
> no longer exists in Python 3.  Instead, we can use a lambda.  Best of
> all, this works in 2.7 just as well.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
