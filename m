Received: from eggs.gnu.org ([2001:4830:134:3::10]:48611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gZwqq-0001mq-4S
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 06:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gZwqm-0001Nl-Tc
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 06:50:52 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:38862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gZwqm-0001Mb-Hi
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 06:50:48 -0500
Date: Thu, 20 Dec 2018 14:50:44 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20181220115044.pge2qoqnldspzdcz@SPB-NB-133.local>
References: <20181220084559.13880-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181220084559.13880-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] ui/cocoa: Include less of the generated
 modular QAPI headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Thu, Dec 20, 2018 at 09:45:59AM +0100, Markus Armbruster wrote:
> Avoids pointless recompilation.  Missed in commit 112ed241f5d.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  ui/cocoa.m | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>

Thanks,
Roman
