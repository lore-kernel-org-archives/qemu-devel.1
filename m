Received: from eggs.gnu.org ([2001:4830:134:3::10]:42277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d85tu-00084E-B2
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d85tr-0002XP-6D
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:14:06 -0400
References: <1494322876-28843-1-git-send-email-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ea74cfd3-9009-e99d-8f18-8edc9c0441c2@redhat.com>
Date: Tue, 9 May 2017 10:14:00 -0400
MIME-Version: 1.0
In-Reply-To: <1494322876-28843-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] docs: Minor updates around ide-drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>



On 05/09/2017 05:41 AM, Markus Armbruster wrote:
> Markus Armbruster (2):
>   docs qemu-doc: Avoid ide-drive, it's deprecated
>   docs/qdev-device-use.txt: update section Default Devices
> 
>  docs/bootindex.txt       |  2 +-
>  docs/qdev-device-use.txt | 13 +++++++------
>  qemu-options.hx          |  2 +-
>  3 files changed, 9 insertions(+), 8 deletions(-)
> 

Shame on me for not noticing, but thank you.

Acked-by: John Snow <jsnow@redhat.com>
