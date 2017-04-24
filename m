Received: from eggs.gnu.org ([2001:4830:134:3::10]:48708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1d2kZA-0002b9-Vb
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 16:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1d2kZ6-0006OT-VD
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 16:26:36 -0400
Received: from h2042504.stratoserver.net ([85.214.107.226]:60204)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1d2kZ6-0006M1-NH
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 16:26:32 -0400
References: <20170418073946.4177-1-git@kirschju.re>
	<20170418073946.4177-5-git@kirschju.re> <20170424163252.GI2362@work-vm>
From: Julian Kirsch <git@kirschju.re>
Message-ID: <e262f9ac-9878-791a-9ba2-aef8d97f98c9@kirschju.re>
Date: Mon, 24 Apr 2017 22:25:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170424163252.GI2362@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND v4 4/4] HMP: Introduce msr_get and
 msr_set HMP commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>

Good catch, thanks!

-Julian

On 24.04.2017 18:32, Dr. David Alan Gilbert wrote:
> Shouldn't the use of '-' be '_' in those to match the .name (and in the -set variant
> below) ?
> 
> Dave
