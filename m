Received: from eggs.gnu.org ([2001:4830:134:3::10]:58535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1g7zsZ-0007Uz-5K
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 05:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1g7zsU-00041Q-3n
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 05:25:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22829)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1g7zsT-00040l-SU
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 05:25:02 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com
	[10.5.11.25])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D2ECC03D474
	for <qemu-devel@nongnu.org>; Thu,  4 Oct 2018 09:25:01 +0000 (UTC)
Date: Thu, 4 Oct 2018 11:24:56 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20181004092456.GB15882@paraplu>
References: <20181003104605.8477-1-kchamart@redhat.com>
	<71d08ec7-cf39-1fd8-141d-ea1eb7175cdb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71d08ec7-cf39-1fd8-141d-ea1eb7175cdb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qapi/misc.json: Remove superfluous words
 in CpuModelExpansionType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ehabkost@redhat.com

On Wed, Oct 03, 2018 at 09:26:26AM -0500, Eric Blake wrote:
> On 10/3/18 5:46 AM, Kashyap Chamarthy wrote:
> > While at it, s/QMU/QEMU in @CpuDefinitionInfo.
> 
> Could mention that it was a repetition of 'independent of'.

Whoever is merging this, please touch up the commit message by adding:

    "Remove repetition of 'independent of'"

Thanks!

[...]

-- 
/kashyap
